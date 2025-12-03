"
I'm part of the Photo gallery example. I'm not expected to be used as a standalone.
See `ToSandBox class>>#example_PicsumPhotosGallery`
"
Class {
	#name : #ToExPicsumImageData,
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
ToExPicsumImageData class >> fromDictionary: aDictionary [
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
ToExPicsumImageData >> author [
	^ author
]

{ #category : #accessing }
ToExPicsumImageData >> author: anObject [
	author := anObject
]

{ #category : #accessing }
ToExPicsumImageData >> authorUrl [
	^ authorUrl
]

{ #category : #accessing }
ToExPicsumImageData >> authorUrl: anObject [
	authorUrl := anObject
]

{ #category : #accessing }
ToExPicsumImageData >> filename [
	^ filename
]

{ #category : #accessing }
ToExPicsumImageData >> filename: anObject [
	filename := anObject
]

{ #category : #accessing }
ToExPicsumImageData >> format [
	^ format
]

{ #category : #accessing }
ToExPicsumImageData >> format: anObject [
	format := anObject
]

{ #category : #accessing }
ToExPicsumImageData >> height [
	^ height
]

{ #category : #accessing }
ToExPicsumImageData >> height: anObject [
	height := anObject
]

{ #category : #accessing }
ToExPicsumImageData >> id [
	^ id
]

{ #category : #accessing }
ToExPicsumImageData >> id: anObject [
	id := anObject
]

{ #category : #accessing }
ToExPicsumImageData >> loadedForm [

	^ loadedForm
]

{ #category : #accessing }
ToExPicsumImageData >> loadedForm: aForm [

	loadedForm := aForm
]

{ #category : #accessing }
ToExPicsumImageData >> postUrl [
	^ postUrl
]

{ #category : #accessing }
ToExPicsumImageData >> postUrl: anObject [
	postUrl := anObject
]

{ #category : #accessing }
ToExPicsumImageData >> width [
	^ width
]

{ #category : #accessing }
ToExPicsumImageData >> width: anObject [
	width := anObject
]
