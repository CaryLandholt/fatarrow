q      = require 'q'
s3     = require 's3'
{DIST_DIRECTORY} = require '../constants'

module.exports = (gulp, plugins) -> ->
	config = require '../../config/s3Config.json'
	{onError} = require('../events') plugins
	deferred  = q.defer()

	client = s3.createClient
		s3Options:
			accessKeyId: config.accessKeyId
			secretAccessKey: config.secretAccessKey

	params =
		localDir: DIST_DIRECTORY
		deleteRemoved: true
		s3Params:
			Bucket: config.bucket

	uploader = client.uploadDir(params)
	uploader.on 'error', (e) ->
		q.reject()
		onError e

	uploader.on 'progress', ->
		console.log 'progress', uploader.progressAmount, uploader.progressTotal

	uploader.on 'end', ->
		console.log 'done uploading'
		deferred.resolve()

	deferred
