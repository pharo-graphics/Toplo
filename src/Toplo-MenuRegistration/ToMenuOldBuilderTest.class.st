Class {
	#name : #ToMenuOldBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'xmenu',
		'tmenu'
	],
	#category : #'Toplo-MenuRegistration-clean'
}

{ #category : #running }
ToMenuOldBuilderTest >> menuBuilder: aClass [

	^ (aClass pragmaKeyword: #worldMenu model: self)
		  menuSpec;
		  yourself
]

{ #category : #running }
ToMenuOldBuilderTest >> setUp [

	xmenu := self menuBuilder: XPragmaMenuBuilder.
	
]

{ #category : #tests }
ToMenuOldBuilderTest >> testEasyOld [

	| xSettings |
	1halt.
	xSettings := (xmenu itemNamed: #Pharo) itemNamed: #Settings
]
