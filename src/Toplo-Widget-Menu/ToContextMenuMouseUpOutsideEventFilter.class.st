Class {
	#name : #ToContextMenuMouseUpOutsideEventFilter,
	#superclass : #ToMenuMouseUpOutsideEventFilter,
	#category : #'Toplo-Widget-Menu-Context menu'
}

{ #category : #testing }
ToContextMenuMouseUpOutsideEventFilter >> isElementIgnored [

	" is the element iside or outside ? 
	ifTrue, a mouse up on the element is considered as an outside event"
	
	" a context menu holder is considered as outside the context menu "
	^ true
]
