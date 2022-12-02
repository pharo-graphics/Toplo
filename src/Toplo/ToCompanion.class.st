Class {
	#name : #ToCompanion,
	#superclass : #Object,
	#traits : 'TToObservable + TBlAnnouncerProvider',
	#classTraits : 'TToObservable classTrait + TBlAnnouncerProvider classTrait',
	#instVars : [
		'userData',
		'installed'
	],
	#category : #'Toplo-Core'
}

{ #category : #converting }
ToCompanion class >> asLook [
	^ self new asLook
]

{ #category : #initialization }
ToCompanion >> initialize [
	self class initializeSlots: self.
	super initialize.
	installed := false.
	self startPostponedActionsStorage
]

{ #category : #accessing }
ToCompanion >> isInstalled [

	^ installed
]

{ #category : #'api - install/uninstall  hook' }
ToCompanion >> launchInstallationIn: anElement [

	installed ifTrue: [ ^ false ].
	installed := true.
	self stopPostponedActionsStorageFor: anElement.
	self onInstalledIn: anElement.
	self performPostponedActions
]

{ #category : #'api - install/uninstall  hook' }
ToCompanion >> launchUninstallationIn: anElement [

	installed ifFalse: [ ^ false ].
	installed := false.
	self onUninstalledIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToCompanion >> onInstalledIn: anElement [

]

{ #category : #'api - install/uninstall  hook' }
ToCompanion >> onUninstalledIn: anElement [

]

{ #category : #'private-postponed actions' }
ToCompanion >> performOrDefer: aBlock [

	"An action is required from an object whose I am a compagnon.
	If I am already associated with it, then aBlock will be performed, else, it will be
	stored and run as soon as possible (typically when onInstalledIn: is sent to myself)"
	self announce: (ToActionRequiredFromCompagnon new
			 valuable: aBlock;
			 yourself)
]

{ #category : #'private-postponed actions' }
ToCompanion >> performPostponedActions [

	"perform stored actions in  the object whose I am a compagnon (as an announcement subscriber)"
	self postponedActions do: [ :announcement | self announce: announcement ].
	self removePostponedActions
]

{ #category : #'private-postponed actions' }
ToCompanion >> postponedActions [

	"postponed actions are store in it"
	^ self userData at: #postponedActions ifAbsentPut: [ OrderedCollection new ]
]

{ #category : #'private-postponed actions' }
ToCompanion >> removePostponedActions [

	self userData removeKey: #postponedActions ifAbsent: [  ]
]

{ #category : #'private-postponed actions' }
ToCompanion >> startPostponedActionsStorage [

	"Since no object is associated with me, I store the actions that I need to evaluate from it"
	self whenAnnouncement: ToActionRequiredFromCompagnon send: #storePostponedAction: to: self
]

{ #category : #'private-postponed actions' }
ToCompanion >> stopPostponedActionsStorageFor: anObject [

	"anObject is associated with me (I am his compagnon). So no more storage is needed anymore,
	actions can be performed from it"
	self unsubscribe: self.
	self whenAnnouncement: ToActionRequiredFromCompagnon send: #whenActionRequired: to: anObject

]

{ #category : #'private-postponed actions' }
ToCompanion >> storePostponedAction: anActionRequired [

	"store an action that will be performed as soon as an object will be associated with me"
	self postponedActions add: anActionRequired.
]

{ #category : #accessing }
ToCompanion >> userData [
	"Returns a Dictionary that holds application dependent and temporary objects.
	Be careful to limit the use of such facility and prefer clean instance variables when it is possible to define them.
	If a user data is used, to ensure maintainability, systematically define relevant accessors and a relase method to get, set and remove
	the user data. The use of the key (which is most of time a symbol ) inside other method is strongly not recommended
	"
	<return: #Dictionary>

	^ userData ifNil: [ userData := IdentityDictionary new ]
]

{ #category : #'accessing - widget' }
ToCompanion >> widgetDo: aBlock [

	self performOrDefer: aBlock
]
