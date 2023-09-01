Class {
	#name : #ToSelectItemDresser,
	#superclass : #ToWidgetDresser,
	#category : #'Toplo-Widget-Select'
}

{ #category : #initialization }
ToSelectItemDresser >> defaultCheckedIconImage [

	^ Smalltalk ui icons iconNamed: 'smallOk'
]

{ #category : #initialization }
ToSelectItemDresser >> defaultUncheckedIconImage [

	^ BlElement new
		  size: 14 @ 14;
		  yourself
]

{ #category : #'events handling' }
ToSelectItemDresser >> leftMouseUpEvent: anEvent in: anElement [

	super leftMouseUpEvent: anEvent in: anElement.
	anElement parentMenuWindow widget close
]
