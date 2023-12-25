Class {
	#name : #ToTestCaseWithSpace,
	#superclass : #TestCase,
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core'
}

{ #category : #running }
ToTestCaseWithSpace >> setUp [ 

	super setUp.
	space := BlSpace new

]
