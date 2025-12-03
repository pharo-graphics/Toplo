Class {
	#name : #ToMenuRegistrationOldTest,
	#superclass : #TestCase,
	#instVars : [
		'menu'
	],
	#category : #'Toplo-MenuRegistration-Old'
}

{ #category : #running }
ToMenuRegistrationOldTest >> setUp [

	super setUp.
	menu := ToMenuRegistrationOld new name: 'TheParent'.
]

{ #category : #tests }
ToMenuRegistrationOldTest >> testHasChildren [

	menu addChild: ToMenuRegistrationOld new.
	self assert: menu hasChildren
]

{ #category : #tests }
ToMenuRegistrationOldTest >> testHasNoChildren [

	self assert: menu hasNoChildren
]

{ #category : #tests }
ToMenuRegistrationOldTest >> testSortChildren [

	menu addChild: (ToMenuRegistrationOld new
			 name: #Child1;
			 order: 99).
	menu addChild: (ToMenuRegistrationOld new
			 name: #Child2;
			 order: 1).
	menu addChild: (ToMenuRegistrationOld new
			 name: #Child3;
			 order: 2).
	menu sortChildren.
	self assert: menu childrenItems first name equals: #Child2.
	self assert: menu childrenItems last name equals: #Child1
]
