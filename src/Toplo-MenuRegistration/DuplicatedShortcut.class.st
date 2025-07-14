"
I'm a simple report element for menu registration. 
"
Class {
	#name : #DuplicatedShortcut,
	#superclass : #ProblemReport,
	#instVars : [
		'shortcut'
	],
	#category : #'Toplo-MenuRegistration-Report'
}

{ #category : #accessing }
DuplicatedShortcut >> shortcut: aString [
	shortcut := aString
]
