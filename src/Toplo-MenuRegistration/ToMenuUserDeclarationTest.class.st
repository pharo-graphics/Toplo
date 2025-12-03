Class {
	#name : #ToMenuUserDeclarationTest,
	#superclass : #TestCase,
	#instVars : [
		'menu'
	],
	#category : #'Toplo-MenuRegistration-New'
}

{ #category : #running }
ToMenuUserDeclarationTest >> setUp [

	super setUp.
	menu := ToMenuUserDeclaration new name: 'TheParent'.
]

{ #category : #tests }
ToMenuUserDeclarationTest >> testHasChildren [

	menu addChild: ToMenuUserDeclaration new.
	self assert: menu hasChildren
]

{ #category : #tests }
ToMenuUserDeclarationTest >> testHasNoChildren [

	self assert: menu hasNoChildren
]

{ #category : #tests }
ToMenuUserDeclarationTest >> testSortChildren [

	menu addChild: (ToMenuUserDeclaration new
			 name: #Child1;
			 order: 99).
	menu addChild: (ToMenuUserDeclaration new
			 name: #Child2;
			 order: 1).
	menu addChild: (ToMenuUserDeclaration new
			 name: #Child3;
			 order: 2).
	menu sortChildren.
	self assert: menu childrenItems first name equals: #Child2.
	self assert: menu childrenItems last name equals: #Child1
]
