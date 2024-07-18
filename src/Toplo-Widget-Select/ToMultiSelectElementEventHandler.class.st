Class {
	#name : #ToMultiSelectElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'api - accessing' }
ToMultiSelectElementEventHandler >> eventsToHandle [

	^ {
		  ToLayoutDirectionChangedEvent.
		  ToLayoutOrientationChangedEvent.
		  BlLayoutResizerChangedEvent }
]

{ #category : #'event handling' }
ToMultiSelectElementEventHandler >> layoutDirectionChangedEvent: anEvent [

	anEvent currentTarget innerContainer leftToRight: anEvent currentTarget isLeftToRight 
]

{ #category : #'event handling' }
ToMultiSelectElementEventHandler >> layoutOrientationChangedEvent: anEvent [

	anEvent currentTarget innerContainer horizontal: anEvent currentTarget isHorizontal
]

{ #category : #'event handling' }
ToMultiSelectElementEventHandler >> layoutResizerChangedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target innerContainer matchParent.
	target isHMatchParent ifFalse: [ target innerContainer hFitContent ].
	target isVMatchParent ifFalse: [ target innerContainer vFitContent ]
]
