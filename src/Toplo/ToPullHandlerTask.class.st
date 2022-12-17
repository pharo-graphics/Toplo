Class {
	#name : #ToPullHandlerTask,
	#superclass : #BlTask,
	#instVars : [
		'pullHandler',
		'event'
	],
	#category : #'Toplo-Core'
}

{ #category : #accessing }
ToPullHandlerTask >> event [

	^ event
]

{ #category : #accessing }
ToPullHandlerTask >> event: anObject [

	event := anObject
]

{ #category : #accessing }
ToPullHandlerTask >> pullHandler [

	^ pullHandler
]

{ #category : #accessing }
ToPullHandlerTask >> pullHandler: anObject [

	pullHandler := anObject
]

{ #category : #running }
ToPullHandlerTask >> run [

	pullHandler launchDragEvent: event.
	pullHandler taskDone
]
