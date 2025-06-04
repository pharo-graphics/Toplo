Class {
	#name : #MorphicVisitor,
	#superclass : #MenuRegistrationVisitor,
	#category : #'MenuRegistration-Visitor'
}

{ #category : #visiting }
MorphicVisitor >> visitMenuBuilder: aMenuBuilder [
	|menus|
	menus := OrderedCollection new.
	aMenuBuilder collectedItems do: [ :item | menus add: (self visitMenuRegistration:item) ].
	menuPane := MenuMorph new." addList: menus."
	menuPane popUpInWorld.
]

{ #category : #visiting }
MorphicVisitor >> visitMenuRegistration: aMenuRegistration [

	| menu |
	aMenuRegistration hasChildren
		ifTrue: [
			menu := MenuMorph new.
			aMenuRegistration childrenItems do: [ :subItem |
				menu add: aMenuRegistration label subMenu: (subItem accept: self).
		 ] ]
		ifFalse: [
			menu := MenuMorph new
				        add: aMenuRegistration label
						  target: aMenuRegistration target
				        selector: aMenuRegistration selector
						  argument: aMenuRegistration arguments;
				        yourself ].
	aMenuRegistration separator ifTrue: [ menu addSeparator ].
]
