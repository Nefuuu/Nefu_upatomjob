-- Job By "𝙉𝙀𝙁𝙐™#6730
-- Discord : https://discord.gg/mtHH5wcZgQ 

INSERT INTO `addon_account` (name, label, shared) VALUES
  ('society_upatom', 'upatom', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  ('society_upatom', 'upatom', 1),
  ('society_upatom_fridge', 'upatom (frigo)', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
    ('society_upatom', 'upatom', 1)
;

INSERT INTO `jobs` (name, label) VALUES
  ('upatom', 'upatom')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('upatom', 0, 'recruit', 'Équipier', 300, '{}', '{}'),
  ('upatom', 1, 'employed', 'Formateur', 300, '{}', '{}'),
  ('upatom', 2, 'viceboss', 'Manager', 500, '{}', '{}'),
  ('upatom', 3, 'boss', 'Gérant', 600, '{}', '{}')
;

INSERT INTO `items` (`name`, `label`) VALUES
('burger', 'Hamburger'),
('Barquette de Frites', 'frite'),
('icetea', 'IceTea'),
('limonade', 'Limonade')