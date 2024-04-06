"
I provide access to icons in png from the file system. 
It receive locations (directory references) where to find them.

Alternatively, it can also look for gtk theme icons (stored by name in the gtk theme).
"
Class {
	#name : #ToLocationIconProvider,
	#superclass : #ToIconProvider,
	#instVars : [
		'icons',
		'locations'
	],
	#category : #'Toplo-Core-Theme'
}

{ #category : #'instance creation' }
ToLocationIconProvider class >> newLocation: aLocation [

	^ self new 
		addLocation: aLocation;
		yourself
]

{ #category : #accessing }
ToLocationIconProvider >> addLocation: aReference [

	locations := locations copyWith: aReference
]

{ #category : #accessing }
ToLocationIconProvider >> iconNamed: aName ifAbsent: aBlock [
	| icon |
	
	aName ifNil: [ ^ aBlock value ].
	icon := icons at: aName ifAbsent: [ nil ].
	icon ifNil: [ 
		icon := self loadIconNamed: aName.
		icon ifNil: [ ^ aBlock value ].
		icons at: aName put: icon ].

	^ icon
]

{ #category : #accessing }
ToLocationIconProvider >> icons [

	^ icons
]

{ #category : #initialization }
ToLocationIconProvider >> initialize [

	super initialize.
	locations := #().
	icons := Dictionary new.
	self initializeBlankIcon
]

{ #category : #initialization }
ToLocationIconProvider >> initializeBlankIcon [

	self setBlankIcon: (Form extent: 16@16 depth: 8)
]

{ #category : #inspecting }
ToLocationIconProvider >> inspectionIcons [
	<inspectorPresentationOrder: 0 title: 'Icons'> 

	^ SpListPresenter new
		items: (icons associations sorted: [ :a :b | a key < b key ]);
		displayIcon: [ :each | each value ];
		display: [ :each | each key ];
		yourself
]

{ #category : #utilities }
ToLocationIconProvider >> loadAllIcons [

	self locations do: [ :eachLocation |
		(eachLocation filesMatching: '*.png') do: [ :each |
			icons 
				at: each basename
				put: (self loadIcon: each) ] ]
]

{ #category : #utilities }
ToLocationIconProvider >> loadIcon: fileReference [

	fileReference exists ifFalse: [ 
		self error: ('Icon {1} does not exit' format: { fileReference fullName }) ].

	^ fileReference binaryReadStreamDo: [ :stream |
		 Form fromBinaryStream: stream ]
]

{ #category : #utilities }
ToLocationIconProvider >> loadIconNamed: aSymbol [

	self locations do: [ :each | | ref |
		ref := (each / aSymbol) withExtension: 'png'.
		ref exists ifTrue: [ 
			^ self loadIcon: ref ] ].
	^ nil
]

{ #category : #accessing }
ToLocationIconProvider >> locations [

	^ locations
]

{ #category : #accessing }
ToLocationIconProvider >> menuIconNamed: aName [ 

	^ self iconNamed: aName
]

{ #category : #accessing }
ToLocationIconProvider >> setBlankIcon: aForm [
	"To be able to specify the form that represents a missing icon."
	
	icons at: #blank put: aForm
]
