Class {
	#name : #ToExListEmbeddedNode,
	#superclass : #ToBasicListNode,
	#category : #'Toplo-Examples-Parts'
}

{ #category : #skin }
ToExListEmbeddedNode >> newRawSkin [

	^ ToScriptableSkin new
		  onInstallSkinEvent: [ :e :evt |
				  e padding: (BlInsets
							   horizontal: (e valueOfTokenNamed: #'list-node-padding-H')
							   vertical: (e valueOfTokenNamed: #'list-node-padding-V')) ];
		  onSelectedSkinEvent: [ :e :evt |
				  e
					  addTokenNamed: #'selected-focused-foreground'
					  withValue: Color red.
				  e
					  addTokenNamed: #'selected-unfocused-foreground'
					  withValue: Color red.
				  e background: Color lightGreen ];
		  onDeselectedSkinEvent: [ :e :evt |
				  e background: Color transparent.
				  e removeTokenNamed: #'selected-focused-foreground'.
				  e removeTokenNamed: #'selected-unfocused-foreground' ];
		  yourself
]
