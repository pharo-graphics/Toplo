Class {
	#name : #ToDressableEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'dresser'
	],
	#category : #'Toplo-Core'
}

{ #category : #accessing }
ToDressableEventHandler >> dresser [

	^ dresser
]

{ #category : #accessing }
ToDressableEventHandler >> dresser: aDresser [

	dresser := aDresser
]

{ #category : #'api - accessing' }
ToDressableEventHandler >> eventsToHandle [

	^ { BlUIEvent. BlMousePickOutsideEvent. ToEnablementChangedEvent }
]

{ #category : #'api - event managing' }
ToDressableEventHandler >> handleEvent: anEvent [

	anEvent sendTo: self dresser
]

{ #category : #'api - event managing' }
ToDressableEventHandler >> wantsEvent: anEvent [

	^ self eventsToHandle anySatisfy: [ :eachEventClass | anEvent isKindOf: eachEventClass ]
]
