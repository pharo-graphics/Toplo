Class {
	#name : 'ToCompanion',
	#superclass : 'Object',
	#traits : 'TObservable + TBlEventTarget',
	#classTraits : 'TObservable classTrait + TBlEventTarget classTrait',
	#instVars : [
		'userData',
		'installed',
		'eventDispatcher',
		'requiredActionsHandler'
	],
	#category : 'Toplo-Core',
	#package : 'Toplo',
	#tag : 'Core'
}

{ #category : 'event management accessing' }
ToCompanion >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher ifNil: [ eventDispatcher := BlDirectEventDispatcher on: self ].
]

{ #category : 'initialization' }
ToCompanion >> initialize [

	super initialize.
	self class initializeSlots: self.
	
	installed := false.
	self startPostponedActionsStorage
]

{ #category : 'accessing' }
ToCompanion >> isInstalled [

	^ installed
]

{ #category : 'api - install/uninstall  hook' }
ToCompanion >> launchInstallationIn: anElement [

	installed ifTrue: [ ^ false ].
	installed := true.
	self stopPostponedActionsStorageFor: anElement.
	self onInstalledIn: anElement.
	self performPostponedActions
]

{ #category : 'api - install/uninstall  hook' }
ToCompanion >> launchUninstallationIn: anElement [

	installed ifFalse: [ ^ false ].
	installed := false.
	self onUninstalledIn: anElement
]

{ #category : 'api - install/uninstall  hook' }
ToCompanion >> onInstalledIn: anElement [


]

{ #category : 'api - install/uninstall  hook' }
ToCompanion >> onUninstalledIn: anElement [

]

{ #category : 'private-postponed actions' }
ToCompanion >> performOrDefer: aBlock [

	"An action is required from an object whose I am a compagnon.
	If I am already associated with it, then aBlock will be performed, else, it will be
	stored and run as soon as possible (typically when onInstalledIn: is sent to myself)"
	self dispatchEvent: (ToActionRequiredEvent new
			 valuable: aBlock;
			 yourself)
]

{ #category : 'private-postponed actions' }
ToCompanion >> performPostponedActions [

	"perform stored actions in  the object whose I am a compagnon (as an announcement subscriber)"
	self postponedActions do: [ :anEvent | self dispatchEvent: anEvent ].
	self removePostponedActions
]

{ #category : 'private-postponed actions' }
ToCompanion >> postponedActions [

	"postponed actions are store in it"
	^ self userData at: #postponedActions ifAbsentPut: [ OrderedCollection new ]
]

{ #category : 'printing' }
ToCompanion >> printOn: aStream [

	aStream
		nextPutAll: self class name;
		nextPutAll: ' @ ';
		store: self identityHash
]

{ #category : 'private-postponed actions' }
ToCompanion >> removePostponedActions [

	self userData removeKey: #postponedActions ifAbsent: [  ]
]

{ #category : 'private-postponed actions' }
ToCompanion >> startPostponedActionsStorage [
	"Since no object is associated with me, I store the actions that I need to evaluate from it"

	requiredActionsHandler := BlEventHandler
		                          on: ToActionRequiredEvent
		                          do: [ :event | self storePostponedAction: event ].
	self addEventHandler: requiredActionsHandler
]

{ #category : 'private-postponed actions' }
ToCompanion >> stopPostponedActionsStorageFor: anObject [
	"anObject is associated with me (I am his compagnon). So no more storage is needed anymore,
	actions can be performed from it"

	self removeEventHandler: requiredActionsHandler.
	requiredActionsHandler := BlEventHandler
		                          on: ToActionRequiredEvent
		                          do: [ :event | anObject whenActionRequired: event ].
	self addEventHandler: requiredActionsHandler
]

{ #category : 'private-postponed actions' }
ToCompanion >> storePostponedAction: anActionRequired [

	"store an action that will be performed as soon as an object will be associated with me"
	self postponedActions add: anActionRequired.
]

{ #category : 'accessing' }
ToCompanion >> userData [
	"Returns a Dictionary that holds application dependent and temporary objects.
	Be careful to limit the use of such facility and prefer clean instance variables when it is possible to define them.
	If a user data is used, to ensure maintainability, systematically define relevant accessors and a relase method to get, set and remove
	the user data. The use of the key (which is most of time a symbol ) inside other method is strongly not recommended
	"
	<return: #Dictionary>

	^ userData ifNil: [ userData := IdentityDictionary new ]
]

{ #category : 'accessing - widget' }
ToCompanion >> widgetDo: aBlock [

	self performOrDefer: aBlock
]
