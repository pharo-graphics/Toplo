Class {
	#name : #ToMultiSelectElementEventHandler,
	#superclass : #ToTripletElementEventHandler,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'api - accessing' }
ToMultiSelectElementEventHandler >> eventsToHandle [

	^ super eventsToHandle, {
		  ToLayoutDirectionChangedEvent.
		  ToLayoutOrientationChangedEvent.
		  BlLayoutResizerChangedEvent }
]

{ #category : #'events handling' }
ToMultiSelectElementEventHandler >> layoutDirectionChangedEvent: anEvent [

	super layoutDirectionChangedEvent: anEvent.
	anEvent currentTarget innerContainer leftToRight: anEvent currentTarget isLeftToRight 
]

{ #category : #'events handling' }
ToMultiSelectElementEventHandler >> layoutOrientationChangedEvent: anEvent [

	super layoutOrientationChangedEvent: anEvent.
	anEvent currentTarget innerContainer horizontal: anEvent currentTarget isHorizontal
]

{ #category : #'events handling' }
ToMultiSelectElementEventHandler >> layoutResizerChangedEvent: anEvent [

	| target |
	super layoutResizerChangedEvent: anEvent.
	target := anEvent currentTarget.
	target innerContainer matchParent.
	target isVMatchParent ifFalse: [ target innerContainer vFitContent ]
]
