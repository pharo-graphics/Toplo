Class {
	#name : #ToMenuWindowManager,
	#superclass : #ToPopupWindowManager,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #testing }
ToMenuWindowManager >> hasInlineWindow [

	^ windowStarter isForInlineWindow
]
