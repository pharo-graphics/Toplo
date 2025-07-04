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
		item isGroup ifFalse: [
			item hasChildren
				ifTrue: [ menuPane addMorphBack: (self visitMenuRegistration: item) ]
				ifFalse: [
				menuPane addMorphBack: (self visitMenuItemResgitration: item) ] ] ].
	menuPane openInWorld
]

{ #category : #visiting }
MorphicVisitor >> visitMenuItemResgitration: aMenuRegistration [

	| menuItem |
	menuItem := ToggleMenuItemMorph new contents: (aMenuRegistration label = ''
					         ifTrue: [ aMenuRegistration name asString ]
					         ifFalse: [ aMenuRegistration label ]).
	aMenuRegistration hasChildren
		ifTrue: [ menuItem := self visitMenuRegistration: aMenuRegistration ]
		ifFalse: [
			menuItem
				target: aMenuRegistration target;
				selector: aMenuRegistration selector;
				arguments: aMenuRegistration arguments ].
	aMenuRegistration separator ifTrue: [ "menuItem addSeparator" ].
	^ menuItem
]

{ #category : #visiting }
MorphicVisitor >> visitMenuRegistration: aMenuRegistration [

	| menu |
	menu := MenuMorph new.
	menu addTitle: (aMenuRegistration label = ''
					         ifTrue: [ aMenuRegistration name asString ]
					         ifFalse: [ aMenuRegistration label ]).
	aMenuRegistration childrenItems do: [ :each |
		each isGroup ifFalse: [
			menu addMorphBack: (self visitMenuItemResgitration: each) ] ].
	^ menu
]
