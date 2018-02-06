class SeqUploader < Shrine

    # # The determine_mime_type plugin allows you to determine and store the actual MIME type of the file analyzed from file content.
    # plugin :determine_mime_type
    # # The remove_attachment plugin allows you to delete attachments through checkboxes on the web form.
    # plugin :remove_attachment
    # # The validation_helpers plugin provides helper methods for validating attached files.
    # plugin :validation_helpers
    # # The pretty_location plugin attempts to generate a nicer folder structure for uploaded files.
    # plugin :pretty_location
    # # Allows you to define processing performed for a specific action.
    # plugin :processing
    # # The versions plugin enables your uploader to deal with versions, by allowing you to return a Hash of files when processing.
    # plugin :versions
    # # The delete_promoted plugin deletes files that have been promoted, after the record is saved. This means that cached files handled by the attacher will automatically get deleted once they're uploaded to store. This also applies to any other uploaded file passed to Attacher#promote.
    # plugin :delete_promoted
    # # The delete_raw plugin will automatically delete raw files that have been uploaded. This is especially useful when doing processing, to ensure that temporary files have been deleted after upload.
    # plugin :delete_raw
    # # The cached_attachment_data plugin adds the ability to retain the cached file across form redisplays, which means the file doesn't have to be reuploaded in case of validation errors.
    # plugin :cached_attachment_data
    # # The recache makes versions available immediately.
    # plugin :recache


    # # Define validations
    # # For a complete list of all validation helpers, see AttacherMethods. http://shrinerb.com/rdoc/classes/Shrine/Plugins/ValidationHelpers/AttacherMethods.html
    # Attacher.validate do
    #     validate_max_size 1.gigabytes, message: 'is too large (max is 1GB)'
    #     validate_mime_type_inclusion ['application/octet-stream']
    # end

end