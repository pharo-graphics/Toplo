Class {
	#name : #ToTestCaseWithSpace,
	#superclass : #BlSpaceTestCase,
	#category : #'Toplo-Tests-Core'
}

{ #category : #'skin management' }
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
