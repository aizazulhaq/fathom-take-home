-- -- SQLite
-- -- SQLite
-- -- SQLite
-- SELECT
--     id,
--     title,
--     thumbnail_url,
--     recording_page_url,
-- FROM
--     meeting_recordings
-- INNER JOIN role_access_policies ON roles.id = role_access_policies.viewer_role_id
-- WHERE
--     viewer_role_id = 1
-- ORDER BY
--     created_at DESC
SELECT * from meeting_recordings
JOIN role_access_policies ON role_access_policies.creator_role_id = meeting_recordings.creator_role_id 
where role_access_policies.viewer_role_id = 1
