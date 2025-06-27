Class {
	#name : #ToLocationIconProvider,
	#superclass : #ToIconProvider,
	#instVars : [
		'icons',
		'locations',
		'fileNameExtension',
		'loaderMap'
	],
	#category : #'Toplo-Core-Theme'
}

{ #category : #'instance creation' }
ToLocationIconProvider class >> newLocation: aLocation forExtension: aFilenameExtension [

	^ self new
		  fileNameExtension: aFilenameExtension;
		  addLocation: aLocation;
		  yourself
]

{ #category : #accessing }
ToLocationIconProvider >> addLocation: aReference [

	locations := locations copyWith: aReference
]

{ #category : #accessing }
ToLocationIconProvider >> defaultFilenameExtension [

	^ 'svg'
]

{ #category : #accessing }
ToLocationIconProvider >> fileNameExtension: aString [

	fileNameExtension := aString
]

{ #category : #accessing }
ToLocationIconProvider >> filenameExtension [

	^ fileNameExtension ifNil: [ fileNameExtension := self defaultFilenameExtension ]
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
	^ ToIcon innerImage: icon
]

{ #category : #accessing }
ToLocationIconProvider >> icons [

	^ icons
]

{ #category : #initialization }
ToLocationIconProvider >> initialize [

	super initialize.
	locations := #().
	self initializeLoaderMap.
	icons := Dictionary new
]

{ #category : #initialization }
ToLocationIconProvider >> initializeLoaderMap [

	loaderMap := IdentityDictionary new.
	loaderMap at: 'png' asSymbol put: [ :aFileReference |
		aFileReference binaryReadStreamDo: [ :stream |
			Form fromBinaryStream: stream ] ].
	loaderMap at: 'svg' asSymbol put: [ :aFileReference |
		| contents |
		([
		 BlSvgConverter convertFromString:
			 (contents := aFileReference readStream contents) ]
			 on: Error
			 do: [  ]) ifNotNil: [ contents ] ]
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
		(eachLocation filesMatching: '*.' , self filenameExtension) do: [
			:each |
			| loaded |
			loaded := self loadIcon: each.
			loaded
				ifNil: [ ('Error: ' , each asString) traceCr ]
				ifNotNil: [ icons at: each basename put: loaded ] ] ]
]

{ #category : #utilities }
ToLocationIconProvider >> loadIcon: fileReference [

	fileReference exists ifFalse: [
		self error:
			('Icon {1} does not exit' format: { fileReference fullName }) ].
	^ ((loaderMap at: fileNameExtension asSymbol) value: fileReference)
		  ifNotNil: [ :loaded | loaded ]
]

{ #category : #utilities }
ToLocationIconProvider >> loadIconNamed: aSymbol [

	self locations do: [ :each | | ref |
		ref := (each / aSymbol) withExtension: self filenameExtension.
		ref exists ifTrue: [ 
			^ self loadIcon: ref ] ].
	^ nil
]

{ #category : #accessing }
ToLocationIconProvider >> locations [

	^ locations
]
