Class {
	#name : #ToploVisitor,
	#superclass : #SMenuDeclarationVisitor,
	#category : #'Toplo-MenuRegistration-New'
}

{ #category : #visiting }
ToploVisitor >> addItemDeclaration: aMenuRegistration to: aMenuContainer [

	aMenuRegistration isGroup
		ifTrue: [
				aMenuRegistration childrenItems do: [ :subItem | self addItemDeclaration: subItem to: aMenuContainer ].
				aMenuRegistration separator ifTrue: [ aMenuContainer addSeparator ] ]
		ifFalse: [
				aMenuContainer addItem: (aMenuRegistration accept: self).
				aMenuRegistration separator ifTrue: [ aMenuContainer addSeparator ] ]
]

{ #category : #initialization }
ToploVisitor >> initialize [

	menuPane := ToMenuPane new
]

{ #category : #visiting }
ToploVisitor >> visitMenuBuilder: aMenuBuilder [

	aMenuBuilder collectedItems do: [ :item | self addItemDeclaration: item to: menuPane ].
	^ menuPane
]

{ #category : #visiting }
ToploVisitor >> visitMenuRegistration: aMenuRegistration [

	| menu |
	aMenuRegistration hasChildren
		ifTrue: [
				menu := ToMenu new labelText: aMenuRegistration curatedLabel.
				aMenuRegistration childrenItems do: [ :subItem | self addItemDeclaration: subItem to: menu ] ]
		ifFalse: [
				menu := ToMenuItem new labelText: aMenuRegistration curatedLabel.
				menu clickAction: aMenuRegistration action.
				aMenuRegistration hasIcon ifTrue: [ menu iconImage: aMenuRegistration icon asElement ] ].
	^ menu
]
