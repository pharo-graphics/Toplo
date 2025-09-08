Class {
	#name : #ToActionPool,
	#superclass : #Object,
	#instVars : [
		'holder',
		'runCount',
		'registeredActionLinks',
		'runningRegisteredActionLinks'
	],
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #accessing }
ToActionPool >> actionLinks [ 

	^ registeredActionLinks collect: [ :ral | ral actionLink ]
]

{ #category : #'private - running' }
ToActionPool >> actionRunRequest: anEvent [

	runningRegisteredActionLinks ifNotNil: [ ^ self ].
	runningRegisteredActionLinks := registeredActionLinks copy
]

{ #category : #'private - running' }
ToActionPool >> actionRunnedEvent: anEvent [

	self checkRunningOf: anEvent actionLink.

	self allRunningActionsAreSynchronized ifFalse: [ ^ self ].

	" notify that all actions are runned "
	self notifyActionPoolRunned
]

{ #category : #'private - running' }
ToActionPool >> allActionsAreRunned [

	^ self registeredActionLinks allSatisfy: [ :ral |
		  ral nextRunCount = (ral actionLink runCount + 1) ]
]

{ #category : #'private - running' }
ToActionPool >> allRunningActionsAreSynchronized [

	^ (runningRegisteredActionLinks allSatisfy: [ :ral |
		 ral nextRunCount = ral actionLink runCount ])
]

{ #category : #'private - running' }
ToActionPool >> checkRunningOf: anActionLink [
	" check if the action link is allowed to run here "

	" is the actionLink in the current runned set ?"
	(self runningActionLinks includes: anActionLink) ifTrue: [ ^ self ].

	" it doesn't but it is registered ? if true, just add it in the current runned set "
	(registeredActionLinks
		 detect: [ :ral | ral actionLink = anActionLink ]
		 ifNone: [ ]) ifNotNil: [ :ral |
			runningRegisteredActionLinks add: ral.
			^ self ].

	" not registered here at all "
	Error signal:
		'Incorrect running state: Maybe action link has not been correctly unregistered '
]

{ #category : #accessing }
ToActionPool >> holder [

	^ holder 
]

{ #category : #accessing }
ToActionPool >> holder: anElement [

	holder := anElement
]

{ #category : #initialization }
ToActionPool >> initialize [ 

	super initialize.
	registeredActionLinks := IdentitySet new.
	runCount := 0
]

{ #category : #'private - running' }
ToActionPool >> notifyActionPoolRunned [

	runningRegisteredActionLinks := nil.
	runCount := runCount + 1.

	self registeredActionLinks do: [ :ral |
		ral nextRunCount: ral actionLink runCount + 1 ].

	holder ifNotNil: [ :h |
			h dispatchEvent: (ToActionPoolRunnedEvent new
					 sourceActionLinkPool: self;
					 yourself) ]
]

{ #category : #'adding / removing' }
ToActionPool >> registerActionLink: anActionLink [

	| registered |
	registered := ToRegisteredActionLink new.
	registered registerActionLink: anActionLink inPool: self.
	registeredActionLinks add: registered
]

{ #category : #accessing }
ToActionPool >> registeredActionLinks [ 

	^ registeredActionLinks 
]

{ #category : #accessing }
ToActionPool >> runCount [

	^ runCount
]

{ #category : #accessing }
ToActionPool >> runCount: anObject [

	runCount := anObject
]

{ #category : #accessing }
ToActionPool >> runningActionLinks [ 

	^ runningRegisteredActionLinks collect: [ :ral | ral actionLink ]
]

{ #category : #'adding / removing' }
ToActionPool >> unregisterActionLink: anActionLink [

	| registered |
	registered := self registeredActionLinks detect: [ :ral |
		              ral actionLink = anActionLink ].
	registered unregisterActionLinkFromPool: self.
	registeredActionLinks remove: registered
]
