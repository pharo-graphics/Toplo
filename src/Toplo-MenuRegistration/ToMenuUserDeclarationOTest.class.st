Class {
	#name : #ToMenuUserDeclarationOTest,
	#superclass : #TestCase,
	#instVars : [
		'menu'
	],
	#category : #'Toplo-MenuRegistration-O'
}

{ #category : #running }
ToMenuUserDeclarationOTest >> setUp [

	super setUp.
	menu := ToMenuUserDeclarationO new name: 'TheParent'.
]

{ #category : #tests }
ToMenuUserDeclarationOTest >> testHasChildren [

	menu addChild: ToMenuUserDeclarationO new.
	self assert: menu hasChildren
]

{ #category : #tests }
ToMenuUserDeclarationOTest >> testHasNoChildren [

	self assert: menu hasNoChildren
]

{ #category : #tests }
ToMenuUserDeclarationOTest >> testSortChildren [

	menu addChild: (ToMenuUserDeclarationO new
			 name: #Child1;
			 order: 99).
	menu addChild: (ToMenuUserDeclarationO new
			 name: #Child2;
			 order: 1).
	menu addChild: (ToMenuUserDeclarationO new
			 name: #Child3;
			 order: 2).
	menu sortChildren.
	self assert: menu childrenItems first name equals: #Child2.
	self assert: menu childrenItems last name equals: #Child1
]
