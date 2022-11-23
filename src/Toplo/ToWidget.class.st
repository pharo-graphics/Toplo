Class {
	#name : #ToWidget,
	#superclass : #BlElement,
	#traits : 'TBlAnnouncerProvider + TToObservable + TToEnableable',
	#classTraits : 'TBlAnnouncerProvider classTrait + TToObservable classTrait + TToEnableable classTrait',
	#instVars : [
		'viewModel'
	],
	#category : #'Toplo-Core'
}

{ #category : #initialization }
ToWidget >> defaultDresser [

	^ ToNullDresser new

]

{ #category : #initialization }
ToWidget >> defaultLayout [

	^ BlLinearLayout horizontal 
]

{ #category : #initialization }
ToWidget >> defaultViewModel [

	^ self subclassResponsibility
]

{ #category : #'accessing - dresser' }
ToWidget >> dresser [
	^ self userData at: #dresser ifAbsent: nil
]

{ #category : #'accessing - dresser' }
ToWidget >> dresser: aDresser [

	self dresserDo: [ :d  | d launchUninstallationIn: self ].
	self userData at: #dresser put: aDresser.
	self dresserDo: [ :d  | d launchInstallationIn: self ].

]

{ #category : #'accessing - dresser' }
ToWidget >> dresserDo: aBlock [
	self dresser ifNotNil: aBlock
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
	self dresser: self defaultDresser
]

{ #category : #'change reporting' }
ToWidget >> invalidate [

	self invalidateModel.
	^ super invalidate
]

{ #category : #'change reporting' }
ToWidget >> invalidateModel [

	self viewModelDo: [ :vm | vm invalidate ]
	
	
]

{ #category : #world }
ToWidget >> openInFrame [

	| frame |
	frame := ToFrame new.
	frame addChild: self.
	frame openInWorld
]

{ #category : #world }
ToWidget >> openInWorld [

	| world |
	world := ToManager world.
	world isOpened ifFalse: [ world show ].
	world root addChild: self
]

{ #category : #accessing }
ToWidget >> viewModel [

	" should be lazy to avoid unecessary instanciation and installation of my viewModel "
	^ viewModel ifNil: [ self viewModel: self defaultViewModel. viewModel ]
]

{ #category : #accessing }
ToWidget >> viewModel: aViewModel [

	" A viewModel is normally installed only once by the widget or by the viewModel itself.
	Installing a new viewModel is possible but be aware of what you are doing (lost of data stored in the installed viewModel)."
	self viewModelDo: [ :aCurrentModel | aCurrentModel launchUninstallationIn: self ].
	viewModel := aViewModel.
	self viewModelDo: [ :aCurrentModel | aViewModel launchInstallationIn: self ]
]

{ #category : #accessing }
ToWidget >> viewModelDo: aBlock [

	viewModel ifNotNil: aBlock
]

{ #category : #'private - model events' }
ToWidget >> whenActionRequired: anActionRequiredAnnouncement [

	anActionRequiredAnnouncement value: self
]
