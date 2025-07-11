Class {
	#name : #ToMenuRegistrationTest,
	#superclass : #TestCase,
	#instVars : [
		'menu'
	],
	#category : #'Toplo-MenuRegistration-Tests'
}

{ #category : #running }
ToMenuRegistrationTest >> setUp [

	super setUp.
	menu := ToMenuRegistration new name: 'TheParent'.
]

{ #category : #tests }
ToMenuRegistrationTest >> testHasChildren [
	menu addChild: ToMenuRegistration new.
	self assert: menu hasChildren
]

{ #category : #tests }
ToMenuRegistrationTest >> testHasNoChildren [

	self assert: menu hasNoChildren
]

{ #category : #tests }
ToMenuRegistrationTest >> testSortChildren [

	menu addChild: (ToMenuRegistration new
			 name: #Child1;
			 order: 99).
	menu addChild: (ToMenuRegistration new
			 name: #Child2;
			 order: 1).
	menu addChild: (ToMenuRegistration new
			 name: #Child3;
			 order: 2).
	menu sortChildren.
	self assert: menu childrenItems first name equals: #Child2.
	self assert: menu childrenItems last name equals: #Child1
]
