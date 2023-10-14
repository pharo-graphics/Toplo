Class {
	#name : 'ToPicsumPhotosGalleryImageData',
	#superclass : 'Object',
	#instVars : [
		'format',
		'filename',
		'author',
		'authorUrl',
		'height',
		'width',
		'postUrl',
		'id',
		'form'
	],
	#category : 'Toplo-Examples',
	#package : 'Toplo-Examples'
}

{ #category : 'instance creation' }
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

{ #category : 'accessing' }
ToPicsumPhotosGalleryImageData >> author [
	^ author
]

{ #category : 'accessing' }
ToPicsumPhotosGalleryImageData >> author: anObject [
	author := anObject
]

{ #category : 'accessing' }
ToPicsumPhotosGalleryImageData >> authorUrl [
	^ authorUrl
]

{ #category : 'accessing' }
ToPicsumPhotosGalleryImageData >> authorUrl: anObject [
	authorUrl := anObject
]

{ #category : 'accessing' }
ToPicsumPhotosGalleryImageData >> filename [
	^ filename
]

{ #category : 'accessing' }
ToPicsumPhotosGalleryImageData >> filename: anObject [
	filename := anObject
]

{ #category : 'accessing' }
ToPicsumPhotosGalleryImageData >> form [
	^ form
]

{ #category : 'accessing' }
ToPicsumPhotosGalleryImageData >> form: aForm [
	form := aForm
]

{ #category : 'accessing' }
ToPicsumPhotosGalleryImageData >> format [
	^ format
]

{ #category : 'accessing' }
ToPicsumPhotosGalleryImageData >> format: anObject [
	format := anObject
]

{ #category : 'accessing' }
ToPicsumPhotosGalleryImageData >> height [
	^ height
]

{ #category : 'accessing' }
ToPicsumPhotosGalleryImageData >> height: anObject [
	height := anObject
]

{ #category : 'accessing' }
ToPicsumPhotosGalleryImageData >> id [
	^ id
]

{ #category : 'accessing' }
ToPicsumPhotosGalleryImageData >> id: anObject [
	id := anObject
]

{ #category : 'accessing' }
ToPicsumPhotosGalleryImageData >> loadUrl: anExtent [
	^ 'https://unsplash.it/', (anExtent x min: 4096) asString, '/', (anExtent y min: 4096) asString,'?image=', self id asString
]

{ #category : 'accessing' }
ToPicsumPhotosGalleryImageData >> postUrl [
	^ postUrl
]

{ #category : 'accessing' }
ToPicsumPhotosGalleryImageData >> postUrl: anObject [
	postUrl := anObject
]

{ #category : 'accessing' }
ToPicsumPhotosGalleryImageData >> width [
	^ width
]

{ #category : 'accessing' }
ToPicsumPhotosGalleryImageData >> width: anObject [
	width := anObject
]
