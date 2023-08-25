Class {
	#name : #ToChoiceBoxItemDresser,
	#superclass : #ToWidgetDresser,
	#category : #'Toplo-Widget-ChoiceBox'
}

{ #category : #initialization }
ToChoiceBoxItemDresser >> defaultCheckedIconImage [

	^ Smalltalk ui icons iconNamed: 'smallOk'
]

{ #category : #initialization }
ToChoiceBoxItemDresser >> defaultUncheckedIconImage [

	^ BlElement new
		  size: 14 @ 14;
		  yourself
]

{ #category : #'events handling' }
ToChoiceBoxItemDresser >> leftMouseUpEvent: anEvent in: anElement [

	super leftMouseUpEvent: anEvent in: anElement.
	anElement parentMenuWindow widget close
]
