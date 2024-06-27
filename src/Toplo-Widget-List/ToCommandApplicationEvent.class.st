Class {
	#name : #ToCommandApplicationEvent,
	#superclass : #BlEvent,
	#instVars : [
		'command'
	],
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #accessing }
ToCommandApplicationEvent >> command [

	^ command
]

{ #category : #accessing }
ToCommandApplicationEvent >> command: aCommand [

	command := aCommand
]
