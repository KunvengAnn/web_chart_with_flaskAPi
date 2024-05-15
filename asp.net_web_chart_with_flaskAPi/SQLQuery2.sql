-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_Weather]
AS
BEGIN
    DECLARE @json nvarchar(max) = N'{"ok":1, "weather": [';

    SELECT @json += FORMATMESSAGE(N'{"weather_id": %d, "temperature": %s, "humidity": %s, "time": "%s"},', 
                                   weather_id, CONVERT(nvarchar(50), temperature), CONVERT(nvarchar(50), humidity), CONVERT(varchar(50), [time], 121))
    FROM Weathers;

    -- Remove the trailing comma
    IF @@ROWCOUNT > 0
        SET @json = LEFT(@json, LEN(@json) - 1);

    SET @json += N']}';

    SELECT @json AS JsonResponse; -- Optionally, you can select or return the JSON string.

END
GO
