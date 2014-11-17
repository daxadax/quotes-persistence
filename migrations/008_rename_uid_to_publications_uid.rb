Sequel.migration do
  up do
    rename_column :publications, :uid, :publication_uid
  end

  down do
    rename_column :quotes, :publication_uid, :uid
  end
end
