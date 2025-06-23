Class {
	#name : #MorphicVisitor,
	#superclass : #MenuRegistrationVisitor,
	#category : #'MenuRegistration-Visitor'
}

{ #category : #initialization }
MorphicVisitor >> initialize [

	menuPane := MenubarMorph new adhereToTop.
]

{ #category : #visiting }
MorphicVisitor >> visitMenuBuilder: aMenuBuilder [

	aMenuBuilder collectedItems do: [ :item |
		item name ifNotNil: [
			item hasChildren
				ifTrue: [ menuPane addMorph: (self visitMenuRegistration: item) ]
				ifFalse: [
				menuPane addMorph: (self visitMenuItemResgitration: item) ] ] ].
	menuPane openInWorld
]

{ #category : #visiting }
MorphicVisitor >> visitMenuItemResgitration: aMenuRegistration [

	| menuItem |
	menuItem := ToggleMenuItemMorph new contents:
				            aMenuRegistration name.
	aMenuRegistration name ifNil: [ ^ menuItem ].
	aMenuRegistration hasChildren
		ifTrue: [ menuItem := self visitMenuRegistration: aMenuRegistration ]
		ifFalse: [
			menuItem
				target: aMenuRegistration target;
				selector: aMenuRegistration selector;
				arguments: aMenuRegistration arguments ].
	aMenuRegistration separator ifTrue: [ menuItem addSeparator ].
	^ menuItem
]

{ #category : #visiting }
MorphicVisitor >> visitMenuRegistration: aMenuRegistration [

	| menu |
	menu := MenuMorph new.
	menu addTitle: aMenuRegistration label.
	aMenuRegistration childrenItems do: [ :each |
		each name ifNotNil: [ menu addMorphBack: (self visitMenuItemResgitration: each) ] ].
	^ menu
]
