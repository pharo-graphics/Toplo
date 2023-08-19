Class {
	#name : #ToToggleButtonDefaultType,
	#superclass : #ToButtonDefaultType,
	#category : #'Toplo-Widget-Toggle-Skins'
}

{ #category : #accessing }
ToToggleButtonDefaultType >> regularBorderLookIn: anElement [

	^ ToBorderLook new
		  disabledPaint: [ :e | e toTheme colorBorderDisabled ];
		  initialPaint: [ :e | Color transparent ];
		  hoverPaint: [ :e | e toTheme colorPrimaryHover ];
		  pressedPaint: [ :e | e toTheme colorPrimaryPressed ];
		  yourself
]
