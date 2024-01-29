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
	anElement skinManagerDo: [ :sm |
		sm requestUninstallSkinIn: anElement ].
	anElement skinManager skinUninstaller ifNotNil: [ :su |
		su applyOn: anElement ].
	anElement ensuredSkinManager requestInstallSkinIn: anElement.
	anElement skinManager skinInstaller ifNotNil: [ :si |
		si applyOn: anElement ].
	anElement spaceDo: [ :sp | sp requestNextPulse ]
]

{ #category : #running }
ToTestCaseWithSpace >> setUp [ 

	super setUp.
	space := BlSpace new

]
