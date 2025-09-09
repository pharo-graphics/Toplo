Class {
	#name : #ToTestCaseWithSpace,
	#superclass : #TestCase,
	#instVars : [
		'space'
	],
	#category : #'Toplo-Tests-Core'
}

{ #category : #'as yet unclassified' }
ToTestCaseWithSpace >> installNewSkinNowIn: anElement [
	" bypass the normal skinRequest/skinInstallation scheme"

	anElement space ifNil: [
		Error signal:
			'A non attached element can''t ask for an immediate skin change ' ].
	anElement ensuredSkinManager requestNewSkinIn: anElement.
	anElement skinManager newSkinRequested ifTrue: [ 
		anElement skinManager installNewSkinIn: anElement ].
	anElement requestSkinApplication
]

{ #category : #running }
ToTestCaseWithSpace >> setUp [ 

	super setUp.
	space := BlSpace new.
	space checkToploPhases 

]
