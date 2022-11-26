Trait {
	#name : #TToWidget,
	#traits : 'TBlAnnouncerProvider + TToObservable + TToEnableable',
	#classTraits : 'TBlAnnouncerProvider classTrait + TToObservable classTrait + TToEnableable classTrait',
	#category : #'Toplo-Core'
}

{ #category : #'t - api - tooltip' }
TToWidget >> checkTooltip [

	self tooltip ifNil: [ self tooltip: self newTooltipWidget ]
]

{ #category : #'t - initialization' }
TToWidget >> defaultDresser [

	^ ToNullDresser new

]

{ #category : #'t - initialization' }
TToWidget >> defaultLayout [

	^ BlLinearLayout horizontal 
]

{ #category : #'t - initialization' }
TToWidget >> defaultViewModel [

	^ self explicitRequirement 
]

{ #category : #'t - accessing - dresser' }
TToWidget >> dresser [
	^ self userData at: #dresser ifAbsent: nil
]

{ #category : #'t - accessing - dresser' }
TToWidget >> dresser: aDresser [

	self dresserDo: [ :d  | d launchUninstallationIn: self ].
	self userData at: #dresser put: aDresser.
	self dresserDo: [ :d  | d launchInstallationIn: self ].

]

{ #category : #'t - accessing - dresser' }
TToWidget >> dresserDo: aBlock [
	self dresser ifNotNil: aBlock
]

{ #category : #'t - change reporting' }
TToWidget >> invalidate [

	self invalidateModel.
	^ super invalidate
]

{ #category : #'t - change reporting' }
TToWidget >> invalidateModel [

	self viewModelDo: [ :vm | vm invalidate ]
	
	
]

{ #category : #'t - api - tooltip' }
TToWidget >> newTooltipWidget [

	^ self tooltipWidgetClass new
]

{ #category : #'t - world' }
TToWidget >> openInInnerWindow [

	| frame |
	frame := ToInnerWindow new.
	frame addChild: self.
	frame openInWorld
]

{ #category : #'t - world' }
TToWidget >> openInWorld [

	| world |
	world := ToManager world.
	world isOpened ifFalse: [ world show ].
	world root addChild: self
]

{ #category : #'t - accessing' }
TToWidget >> tooltip [

	^ self userData at: #tooltip ifAbsent: [  ]
]

{ #category : #'t - accessing' }
TToWidget >> tooltip: aTooltip [

	self userData at: #tooltip put: aTooltip
]

{ #category : #'t - api - tooltip' }
TToWidget >> tooltipContent [

	^ self tooltip ifNotNil: [ :tooltip | tooltip content ]
]

{ #category : #'t - api - tooltip' }
TToWidget >> tooltipContent: aTooltipContent [

	self checkTooltip.
	self tooltip content: aTooltipContent asRopedText

]

{ #category : #'t - accessing' }
TToWidget >> tooltipDo: aBlock [

	self tooltip
		ifNil: [ ^ self ]
		ifNotNil: [ :tooltip | aBlock value: tooltip ]
]

{ #category : #'t - api - tooltip' }
TToWidget >> tooltipString: aString [

	"Set a help string to display to the user if he let the mouse over the widget (a tooltip)."

	self tooltipContent: aString asRopedText
]

{ #category : #'t - api - tooltip' }
TToWidget >> tooltipWidgetClass [

	^ ToTooltip 
]

{ #category : #'t - accessing' }
TToWidget >> viewModel [

	" should be lazy to avoid unecessary instanciation and installation "
	^ self userData at: #viewModel ifAbsent: [  ]
]

{ #category : #'t - accessing' }
TToWidget >> viewModel: aViewModel [

	" A viewModel is normally installed only once by the widget or by the viewModel itself.
	Installing a new viewModel is possible but be aware of what you are doing (lost of data stored in the installed viewModel)."
	self viewModelDo: [ :aCurrentModel | aCurrentModel launchUninstallationIn: self ].
	self userData at: #viewModel put: aViewModel.
	self viewModelDo: [ :aCurrentModel | aViewModel launchInstallationIn: self ]
]

{ #category : #'t - accessing' }
TToWidget >> viewModelDo: aBlock [

	self viewModel ifNotNil: aBlock
]

{ #category : #'t - private - model events' }
TToWidget >> whenActionRequired: anActionRequiredFromCompagnon [

	anActionRequiredFromCompagnon value: self
]

{ #category : #'t - api - properties change hook' }
TToWidget >> whenTooltipChangedDo: aBlock [
	"Inform when tooltip property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self checkTooltip.
	self tooltip whenContentChangedDo: aBlock
]
