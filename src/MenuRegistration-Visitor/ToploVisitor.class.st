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
		item isGroup ifFalse: [
			menuPane addChild: (item accept: self) ] ].
	self show
]

{ #category : #visiting }
ToploVisitor >> visitMenuRegistration: aMenuRegistration [

	| menu |
	
	aMenuRegistration hasChildren
		ifTrue: [
			menu := ToMenu new labelText: aMenuRegistration curatedLabel.
		
			aMenuRegistration childrenItems do: [ :subItem |
				subItem isGroup ifFalse: [ menu addItem: (subItem accept: self) ] ].
			aMenuRegistration separator ifTrue: [ menu addSeparator ]. ]
		ifFalse: [
			menu := ToMenuItem new labelText: aMenuRegistration curatedLabel.
			menu clickAction: aMenuRegistration action.
			aMenuRegistration hasIcon ifTrue: [ menu iconImage: aMenuRegistration icon asElement ] ].
	^ menu
]
