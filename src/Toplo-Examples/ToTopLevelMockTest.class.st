Class {
	#name : #ToTopLevelMockTest,
	#superclass : #TestCase,
	#category : #'Toplo-Examples-TopLevel'
}

{ #category : #tests }
ToTopLevelMockTest >> closeWindows [

	Toplo closeSpaces
]

{ #category : #tests }
ToTopLevelMockTest >> testMocks [

	| errors |

	self skip.
	errors := OrderedCollection new.

	{
		ToExLoginPage.
		ToExMiniBrowser.
		ToExWorkspace } do: [ :each |
		[
		each open.
		Delay forMilliseconds: 5000.
		self closeWindows ]
			on: Error
			do: [ :err | errors add: each ] ].


	self
		assert: errors isEmpty
		description:
		'The following examples are broken: ' , errors printString
]
