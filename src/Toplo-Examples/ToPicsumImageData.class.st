"
I'm part of the Photo gallery example. I'm not expected to be used as a standalone.
"
Class {
	#name : #ToPicsumImageData,
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
ToPicsumImageData class >> fromDictionary: aDictionary [
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
ToPicsumImageData >> author [
	^ author
]

{ #category : #accessing }
ToPicsumImageData >> author: anObject [
	author := anObject
]

{ #category : #accessing }
ToPicsumImageData >> authorUrl [
	^ authorUrl
]

{ #category : #accessing }
ToPicsumImageData >> authorUrl: anObject [
	authorUrl := anObject
]

{ #category : #accessing }
ToPicsumImageData >> filename [
	^ filename
]

{ #category : #accessing }
ToPicsumImageData >> filename: anObject [
	filename := anObject
]

{ #category : #accessing }
ToPicsumImageData >> format [
	^ format
]

{ #category : #accessing }
ToPicsumImageData >> format: anObject [
	format := anObject
]

{ #category : #accessing }
ToPicsumImageData >> height [
	^ height
]

{ #category : #accessing }
ToPicsumImageData >> height: anObject [
	height := anObject
]

{ #category : #accessing }
ToPicsumImageData >> id [
	^ id
]

{ #category : #accessing }
ToPicsumImageData >> id: anObject [
	id := anObject
]

{ #category : #accessing }
ToPicsumImageData >> loadedForm [

	^ loadedForm
]

{ #category : #accessing }
ToPicsumImageData >> loadedForm: aForm [

	loadedForm := aForm
]

{ #category : #accessing }
ToPicsumImageData >> postUrl [
	^ postUrl
]

{ #category : #accessing }
ToPicsumImageData >> postUrl: anObject [
	postUrl := anObject
]

{ #category : #accessing }
ToPicsumImageData >> width [
	^ width
]

{ #category : #accessing }
ToPicsumImageData >> width: anObject [
	width := anObject
]
