"
https://ant.design/components/button

To trigger an operation.
When To Use

A button means an operation (or a series of operations). Clicking a button will trigger corresponding business logic.

In Ant Design we provide 5 types of button.

    Primary button: indicate the main action, one primary button at most in one section.
    Default button: indicate a series of actions without priority.
    Dashed button: used for adding action commonly.
    Text button: used for the most secondary action.
    Link button: used for external links.

And 4 other properties additionally.

    danger: used for actions of risk, like deletion or authorization.
    ghost: used in situations with complex background, home pages usually.
    disabled: when actions are not available.
    loading: add loading spinner in button, avoiding multiple submits too.
"
Class {
	#name : #ToAbstractButtonSkin,
	#superclass : #ToAbstractSkin,
	#category : #'Toplo-LookAndFeel-Skins - Buttons'
}

{ #category : #testing }
ToAbstractButtonSkin class >> isAbstract [

	^ self = ToAbstractButtonSkin
]

{ #category : #accessing }
ToAbstractButtonSkin >> background [

	^ self tokens at: #background
]

{ #category : #accessing }
ToAbstractButtonSkin >> border [

	^ self tokens at: #border
]

{ #category : #built }
ToAbstractButtonSkin >> buildTokens [

	super buildTokens.
	
	self tokens at: #background put: self builtBackground.
	self tokens at: #border put: self builtBorder.
]

{ #category : #built }
ToAbstractButtonSkin >> builtBackground [ 

	^ self subclassResponsibility 
]

{ #category : #built }
ToAbstractButtonSkin >> builtBorder [

	^ self builtBorderBuilder build
]

{ #category : #built }
ToAbstractButtonSkin >> builtBorderBuilder [

	| builder |
	builder := BlBorderBuilder new
		           paint: self theme colorBorder;
		           width: self theme lineWidth;
		           lineCap: BlStrokeLineCap butt;
		           lineJoin: BlStrokeLineJoin miter;
		           miterLimit: 4.0;
		           dashOffset: 0.

	self theme lineType = #solid ifTrue:[builder dashArray: #()].
	self theme lineType = #dashed ifTrue:[builder dashArray: #( 6 4.2 )].

	^ builder
]

{ #category : #built }
ToAbstractButtonSkin >> builtGeometry [

	^ BlRoundedRectangleGeometry cornerRadius: self theme borderRadius
]

{ #category : #built }
ToAbstractButtonSkin >> builtIconSkin [

	^ nil
]

{ #category : #built }
ToAbstractButtonSkin >> builtLabelSkin [

	^ ToDefaultLabelSkin new
]

{ #category : #accessing }
ToAbstractButtonSkin >> geometry [

	^ self tokens at: #geometry
]
