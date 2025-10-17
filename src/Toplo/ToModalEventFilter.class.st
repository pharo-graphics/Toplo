Class {
	#name : #ToModalEventFilter,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'contextStack'
	],
	#category : #'Toplo-Support-EventGenerator'
}

{ #category : #'api - accessing' }
ToModalEventFilter >> eventsToHandle [

	^ { BlUIEvent }
]

{ #category : #initialization }
ToModalEventFilter >> initialize [ 

	super initialize.
	contextStack := Stack new
]

{ #category : #'api - hooks' }
ToModalEventFilter >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self pushRoot: anElement 
]

{ #category : #'api - hooks' }
ToModalEventFilter >> onUninstalledIn: anElement [

	contextStack removeAll.
	super onUninstalledIn: anElement.

]

{ #category : #'context managing' }
ToModalEventFilter >> popRoot [

	contextStack pop
]

{ #category : #'context managing' }
ToModalEventFilter >> pushRoot: anElement [

	contextStack push: (Array streamContents: [ :stream |
			 stream nextPutAll: anElement children ])
]
