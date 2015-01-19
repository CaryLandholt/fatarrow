class Upload extends Controller
	constructor: ($log, $upload) ->
		@fileSelected = (files, event) ->
			for file in files
				config =
					file: file
					method: 'POST'
					url: 'api/upload'

				upload = $upload
					.upload config
					.progress (evt) ->
						$log.info "progress: #{parseInt(100.0 * evt.loaded / evt.total)}% file : #{evt.config.file.name}"
					.success (data, status, headers, cfg) ->
						$log.info "file #{cfg.file.name} was uploaded successfully.  Response #{data}"
					.error ->
						$log.error 'actually uploaded.  need to fix'