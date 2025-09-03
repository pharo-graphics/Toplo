Class {
	#name : #ToOneShotMouseUpOutsideEventFilter,
	#superclass : #ToMouseUpOutsideEventFilter,
	#category : #'Toplo-Support-EventGenerator'
}

{ #category : #'api - event managing' }
ToOneShotMouseUpOutsideEventFilter >> handleEvent: anEvent [

	super handleEvent: anEvent.
	holder removeEventFilter: self
]
