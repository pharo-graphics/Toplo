Class {
	#name : #ToStyleSheetThemeSpecWithSkin,
	#superclass : #ToStyleSheetThemeSpec,
	#traits : 'TToBlElementReceiverSpec',
	#classTraits : 'TToBlElementReceiverSpec classTrait',
	#instVars : [
		'skin',
		'skinPage'
	],
	#category : #'Toplo-IDE'
}

{ #category : #'as yet unclassified' }
ToStyleSheetThemeSpecWithSkin >> blElement: aBlElement [

	self skin: nil.
	aBlElement ifNil: [ ^ self ].
	(aBlElement userData at: #skinManager)
		ifNil: [ ^ self ]
		ifNotNil: [ :manager | self skin: manager installedSkin ]
]

{ #category : #initialization }
ToStyleSheetThemeSpecWithSkin >> initializePresenters [

	super initializePresenters.
	skinPage :=  (SpNotebookPage title: 'Selected Skin' provider: [ self providerSelectedSkin ]).
	self notebook
		addPage: skinPage
]

{ #category : #'as yet unclassified' }
ToStyleSheetThemeSpecWithSkin >> providerSelectedSkin [

	self skin ifNil: [ ^ SpLabelPresenter new label: 'No Skin selected.'; yourself ].
	(self skin isKindOf: ToStyleSheetSkin) ifFalse: [
		^ SpLabelPresenter new label: 'Not a ToStyleSkin.'; yourself ].
	^ ToLookEventListenersTableSpec new lookEventListeners:
		  self skin lookEventListeners
]

{ #category : #accessing }
ToStyleSheetThemeSpecWithSkin >> skin [

	^ skin
]

{ #category : #accessing }
ToStyleSheetThemeSpecWithSkin >> skin: anObject [

	skin := anObject.
	self notebook updatePageContent: self skinPage
]

{ #category : #accessing }
ToStyleSheetThemeSpecWithSkin >> skinPage [

	^ skinPage
]
