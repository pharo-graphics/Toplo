"
I'm part of the Photo gallery example. I'm not expected to be used as a standalone.
"
Class {
	#name : #ToPicsumPhotosGalleryImageData,
	#superclass : #Object,
	#instVars : [
		'format',
		'filename',
		'author',
		'authorUrl',
		'height',
		'width',
		'postUrl',
		'id',
		'loadedForm'
	],
	#category : #'Toplo-Examples-PhotoGalleryParts'
}

{ #category : #'instance creation' }
ToPicsumPhotosGalleryImageData class >> fromDictionary: aDictionary [
	^ self new
		format: (aDictionary at: #format);
		filename: (aDictionary at: #filename);
		author: (aDictionary at: #author);
		authorUrl: (aDictionary at: #author_url);
		height: (aDictionary at: #height);
		postUrl: (aDictionary at: #post_url);
		id: (aDictionary at: #id);
		width: (aDictionary at: #width);
		yourself
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageData >> author [
	^ author
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageData >> author: anObject [
	author := anObject
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageData >> authorUrl [
	^ authorUrl
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageData >> authorUrl: anObject [
	authorUrl := anObject
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageData >> filename [
	^ filename
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageData >> filename: anObject [
	filename := anObject
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageData >> format [
	^ format
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageData >> format: anObject [
	format := anObject
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageData >> height [
	^ height
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageData >> height: anObject [
	height := anObject
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageData >> id [
	^ id
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageData >> id: anObject [
	id := anObject
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageData >> loadedForm [

	^ loadedForm
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageData >> loadedForm: aForm [

	loadedForm := aForm
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageData >> postUrl [
	^ postUrl
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageData >> postUrl: anObject [
	postUrl := anObject
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageData >> width [
	^ width
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageData >> width: anObject [
	width := anObject
]
