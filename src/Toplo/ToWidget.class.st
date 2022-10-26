Class {
	#name : #ToWidget,
	#superclass : #BlElement,
	#instVars : [
		'viewModel'
	],
	#category : #'Toplo-Core'
}

{ #category : #initialization }
ToWidget >> defaultBackground [
	^ Color transparent
]

{ #category : #initialization }
ToWidget >> defaultViewModel [

	^ self subclassResponsibility
]

{ #category : #initialization }
ToWidget >> initialize [

	self class initializeSlots: self.
	super initialize.
	self background: self defaultBackground
]

{ #category : #accessing }
ToWidget >> viewModel [

	" should be lazy to avoid unecessary instanciation and installation of my viewModel "
	^ viewModel ifNil: [ self viewModel: self defaultViewModel ]
]

{ #category : #accessing }
ToWidget >> viewModel: aViewModel [

	" A viewModel is normally installed only once by the widget or by the viewModel itself.
	Installing a new viewModel is possible but be aware of what you are doing (lost of data stored in the installed viewModel).
	To reinstall a viewModel first send #viewModel: with nil as argument to uninstall the previous viewModel 
	then send #viewModel: with the new one as argument."
	self assert: (aViewModel isNil or: [aViewModel notNil and: [viewModel isNil]]).
	self viewModelDo: [ :aCurrentModel | aCurrentModel onUninstalledIn: self ].
	viewModel := aViewModel.
	self viewModelDo: [ :aCurrentModel | aViewModel onInstalledIn: self ]
]

{ #category : #enumerating }
ToWidget >> viewModelDo: aBlock [
	viewModel ifNotNil: aBlock
]

{ #category : #'model - events' }
ToWidget >> whenActionRequired: anActionRequiredAnnouncement [

	anActionRequiredAnnouncement value: self
]
