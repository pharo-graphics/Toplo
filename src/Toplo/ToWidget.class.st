Class {
	#name : #ToWidget,
	#superclass : #BlElement,
	#traits : 'TToEnableable',
	#classTraits : 'TToEnableable classTrait',
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
ToWidget >> defaultLayout [

	^ BlLinearLayout horizontal 
]

{ #category : #initialization }
ToWidget >> defaultMargins [

	^ BlInsets empty
		  
]

{ #category : #initialization }
ToWidget >> defaultPaddings [

	^ BlInsets empty
		  
]

{ #category : #initialization }
ToWidget >> defaultViewModel [

	^ self subclassResponsibility
]

{ #category : #'api - enablement' }
ToWidget >> enablementChangedWith: aBoolean [
	self enabled: aBoolean.
	self invalidate
	
]

{ #category : #'api - help' }
ToWidget >> help [

	^ self viewModel help
]

{ #category : #'api - help' }
ToWidget >> help: aText [

	self viewModel help: aText
]

{ #category : #'api - help' }
ToWidget >> helpString: aString [

	self viewModel helpString: aString
]

{ #category : #initialization }
ToWidget >> initialize [

	self class initializeSlots: self.
	super initialize.
	self background: self defaultBackground.
	self layout: self defaultLayout.
	self padding: self defaultPaddings.
	self margin: self defaultMargins
]

{ #category : #'change reporting' }
ToWidget >> invalidate [

	self invalidateModel.
	^ super invalidate
]

{ #category : #'change reporting' }
ToWidget >> invalidateModel [

	self viewModelDo: [ :m | m invalidate].
	
	
]

{ #category : #accessing }
ToWidget >> viewModel [

	" should be lazy to avoid unecessary instanciation and installation of my viewModel "
	^ viewModel ifNil: [ self viewModel: self defaultViewModel. viewModel ]
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

{ #category : #accessing }
ToWidget >> viewModelDo: aBlock [
	viewModel ifNotNil: aBlock
]

{ #category : #'private - model events' }
ToWidget >> whenActionRequired: anActionRequiredAnnouncement [

	anActionRequiredAnnouncement value: self
]
