Class {
	#name : #ToSegmentedElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #'api - accessing' }
ToSegmentedElementEventHandler >> eventsToHandle [

	^ {
		  ToLayoutDirectionChangedEvent.
		  ToLayoutOrientationChangedEvent.
		  BlLayoutResizerChangedEvent }
]

{ #category : #'event handling' }
ToSegmentedElementEventHandler >> layoutDirectionChangedEvent: anEvent [

	anEvent currentTarget barElement leftToRight: anEvent currentTarget isLeftToRight 
]

{ #category : #'event handling' }
ToSegmentedElementEventHandler >> layoutOrientationChangedEvent: anEvent [

	anEvent currentTarget barElement horizontal: anEvent currentTarget isHorizontal
]

{ #category : #'event handling' }
ToSegmentedElementEventHandler >> layoutResizerChangedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target barElement matchParent.
	target isHMatchParent ifFalse: [ target barElement hFitContent ].
	target isVMatchParent ifFalse: [ target barElement vFitContent ]
]
