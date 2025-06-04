Class {
	#name : #ToploVisitor,
	#superclass : #MenuRegistrationVisitor,
	#category : #'MenuRegistration-Visitor'
}

{ #category : #initialization }
ToploVisitor >> initialize [

	menuPane := ToMenuPane new
]

{ #category : #'host space - displaying' }
ToploVisitor >> show [
	|space|
	space := BlSpace new.
	space root addChild: menuPane.
	space show.
]

{ #category : #visiting }
ToploVisitor >> visitMenuBuilder: aMenuBuilder [
	aMenuBuilder collectedItems do: [ :item |
		menuPane addChild: (item accept: self) ].
	self show
]

{ #category : #visiting }
ToploVisitor >> visitMenuRegistration: aMenuRegistration [

	| menu |
	aMenuRegistration hasChildren
		ifTrue: [
			menu := ToMenu new labelText: aMenuRegistration label.
			aMenuRegistration childrenItems do: [ :subItem |
				menu addItem: (subItem accept: self).
		 ] ]
		ifFalse: [
			menu := ToMenuItem new
				        labelText: aMenuRegistration label;
				        clickAction: aMenuRegistration action;
				        yourself ].
	aMenuRegistration separator ifTrue: [ menu addSeparator ].
	^ menu
]
