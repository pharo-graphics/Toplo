"
I dispatch events directly to the registered event handlers.
"
Class {
	#name : #ToSkinEventDispatcher,
	#superclass : #BlEventDispatcher,
	#instVars : [
		'owner',
		'handlers'
	],
	#category : #'Toplo-Core-Skin'
}

{ #category : #'instance creation' }
ToSkinEventDispatcher class >> on: aTBlEventTarget [

	^ self new
		owner: aTBlEventTarget;
		yourself
]

{ #category : #'api - adding/removing' }
ToSkinEventDispatcher >> addEventHandler: aHandler [

	"Lazy initialization"
	handlers ifNil: [ handlers := self newHandlerRegistry ].
	handlers add: aHandler.

	"send hook AFTER handler is added"
	aHandler onInstalledIn: self owner
]

{ #category : #'api - event managing' }
ToSkinEventDispatcher >> dispatchEvent: anEvent next: aBlEventDispatcherChain [

	anEvent isConsumed ifTrue: [ ^ anEvent ].
	anEvent arrivedTarget: self owner.
	"handlers initialized lazily, do nothing if there are none of them"
	handlers ifNotNil: [ :theHandlers |
		theHandlers dispatchEvent: anEvent ].

	^ anEvent
]

{ #category : #'api - accessing' }
ToSkinEventDispatcher >> filtersDo: aBlock [
	"Evaulate a given block with every event filter as an argument"
	
	
]

{ #category : #'api - accessing' }
ToSkinEventDispatcher >> handlersDo: aBlock [
	"Evaulate a given block with every event handler as an argument"

	handlers ifNotNil: [ :aRegistry | aRegistry handlers do: aBlock ]
]

{ #category : #'api - testing' }
ToSkinEventDispatcher >> hasHandler: anEventHandler [

	^ handlers
		  ifNil: [ false ]
		  ifNotNil: [ handlers hasHandler: anEventHandler ]
]

{ #category : #initialization }
ToSkinEventDispatcher >> initialize [

	super initialize.
	handlers := nil
]

{ #category : #initialization }
ToSkinEventDispatcher >> newHandlerRegistry [

	^ BlHandlerRegistry preferableHandlerRegistryClass new
]

{ #category : #'api - accessing' }
ToSkinEventDispatcher >> owner [

	^ owner
]

{ #category : #'private - accessing' }
ToSkinEventDispatcher >> owner: aTBlEventTarget [

	owner := aTBlEventTarget
]

{ #category : #printing }
ToSkinEventDispatcher >> printOn: aStream [

 	super printOn: aStream.
 	aStream
 		nextPutAll: '(owner: ';
 		nextPutAll: owner asString;
 		nextPut: $)
]

{ #category : #'api - adding/removing' }
ToSkinEventDispatcher >> removeEventHandler: anHandler [

	(self hasHandler: anHandler) ifFalse: [ ^ self ].

	handlers ifNil: [ ^ self ].
	handlers remove: anHandler.
	"free memory as soon as we got rid of all event handlers"
	handlers isEmpty ifTrue: [ handlers := nil ].

	anHandler onUninstalledIn: self owner
]

{ #category : #'api - adding/removing' }
ToSkinEventDispatcher >> removeEventHandlers [
	"Remove all my event handlers"

	| oldHandlers |
	handlers ifNil: [ ^ self ].

	oldHandlers := handlers.
	handlers := nil.

	oldHandlers do: [ :eachHandler |
		eachHandler onUninstalledIn: self owner ]
]

{ #category : #'api - adding/removing' }
ToSkinEventDispatcher >> removeEventHandlersSuchThat: aBlock [
	"Remove all event handlers for those aBlock returns true"

	| toBeRemoved |
	handlers ifNil: [ ^ self ].

	toBeRemoved := handlers removeAllSuchThat: aBlock.
	handlers isEmpty ifTrue: [ handlers := nil ].

	toBeRemoved do: [ :aHandler | aHandler onUninstalledIn: self owner ]
]

{ #category : #'api - event managing' }
ToSkinEventDispatcher >> wantsEvent: anEvent [
	"Return true if there are any filters or handlers interesting in a given event,
	false otherwise"

	(handlers isNotNil and: [
		handlers anySatisfy: [ :aHandler | aHandler wantsEvent: anEvent ] ])
			ifTrue: [ ^ true ].

	^ false
]
