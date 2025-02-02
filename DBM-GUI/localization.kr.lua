if GetLocale() ~= "koKR" then return end

if not DBM_GUI_Translations then DBM_GUI_Translations = {} end
local L = DBM_GUI_Translations

L.MainFrame = "죽이는 보스 모드"

L.TranslationByPrefix		= "제작/번역: "
L.TranslationBy 			= "법사세린(Tag: 세린#3105/everfinale@gmail.com)"
L.Website					= "문의/건의사항은 DBM 사용자 포럼을 이용하세요. |cFF73C2FB주소는 여기를 클릭|r (와우 인벤 제공)"
L.WebsiteButton				= "사용자 포럼"

L.OTabBosses	= "우두머리"
L.OTabOptions	= "설정"

L.TabCategory_Options		= "기본 설정"
L.TabCategory_MOP			= "판다리아의 안개"
L.TabCategory_CATA	 		= "대격변"
L.TabCategory_WOTLK 		= "리치왕의 분노"
L.TabCategory_BC 			= "불타는 성전"
L.TabCategory_CLASSIC 		= "오리지널"
--L.TabCategory_PVP 			= "PvP"
L.TabCategory_OTHER			= "기타 우두머리 경보"

L.BossModLoaded 			= "%s 공략 상황"
L.BossModLoad_now 			= [[이 우두머리 경보는 현재 비활성화 상태입니다. 
불러오기 버튼을 클릭하여 우두머리 경보를 불러올 수 있습니다.
]]

L.PosX						= '위치 X'
L.PosY						= '위치 Y'

L.MoveMe 					= '위치 이동'
L.Button_OK					= '확인'
L.Button_Cancel				= '취소'
L.Button_LoadMod			= '불러오기'
L.Mod_Enabled				= "경보 사용"
L.Mod_Reset					= "이 전투의 기본 설정 불러오기"
L.Reset						= "초기화"

L.Enable					= "켜기"
L.Disable					= "비활성화"

L.NoSound					= "끄기"

L.IconsInUse				= "현재 전투에서 사용 되는 전술 목표 아이콘:"

-- Tab: Boss Statistics
L.BossStatistics			= "공략 상황"
L.Statistic_Kills			= "승리:"
L.Statistic_Wipes			= "전멸:"
L.Statistic_Incompletes		= "미완료:"
L.Statistic_BestKill		= "최고 기록:"

-- Tab: General Core Options
L.General 					= "기본 DBM 설정"
L.EnableDBM 				= "DBM 사용"
L.EnableMiniMapIcon			= "미니맵 버튼 사용"
L.SetPlayerRole				= "파티 또는 공격대 참여시 역할 자동 설정(추천)"
L.UseMasterVolume			= "주 음량 설정에 맞추어 애드온 소리 듣기"
L.LFDEnhance				= "전장/공격대 찾기 입장, 역할 확인 소리를 주 음량 설정에 맞추어 듣기"
L.AutologBosses				= "우두머리 전투시 블리자드 전투 기록 자동 활성화"
L.AdvancedAutologBosses		= "우두머리 전투시 Transcriptor 기록 자동 활성화"
L.LogOnlyRaidBosses			= "공격대 우두머리 전투만 기록하기(공격대 찾기 제외)"
L.Latency_Text				= "동기화 신호를 보낼 최대 지연시간 설정: %d"
-- Tab: General Timer Options
L.TimerGeneral 				= "DBM 바 설정"
L.SKT_Enabled				= "우두머리별 설정을 무시하고 최고 기록 바 항상 보기"
L.ChallengeTimerOptions		= "도전 모드 최고 기록 바 설정"
L.ChallengeTimerPersonal	= "개인 기록으로 보기"
L.ChallengeTimerGuild		= "길드 기록으로 보기"
L.ChallengeTimerRealm		= "서버 기록으로 보기"

L.ModelOptions				= "3D 초상화 배경 설정"
L.EnableModels				= "각 우두머리 설정에 3D 초상화 배경 사용"
L.ModelSoundOptions			= "각 우두머리 설정을 볼 때 출력될 음성 선택"
L.ModelSoundShort			= "짧은 음성"
L.ModelSoundLong			= "긴 음성"

L.Button_RangeFrame			= "거리 창 보기(문자형)"
L.Button_RangeRadar			= "거리 창 보기(아이콘형)"
L.Button_InfoFrame			= "정보 창 이동"
L.Button_TestBars			= "시험 경보 시작"

L.PizzaTimer_Headline 		= '사용자 지정 바 만들기'
L.PizzaTimer_Title			= '이름(예: "Pizza!")'
L.PizzaTimer_Hours 			= "시"
L.PizzaTimer_Mins 			= "분"
L.PizzaTimer_Secs 			= "초"
L.PizzaTimer_ButtonStart 	= "바 시작"
L.PizzaTimer_BroadCast		= "공격대에 알리기"

-- Tab: Raidwarning
L.Tab_RaidWarning 			= "알림 설정"
L.RaidWarning_Header		= "알림 설정"
L.RaidWarnColors 			= "알림 색상"
L.RaidWarnColor_1 			= "색상 1"
L.RaidWarnColor_2 			= "색상 2"
L.RaidWarnColor_3 			= "색상 3"
L.RaidWarnColor_4 			= "색상 4"
L.InfoRaidWarning			= [[공격대 경보 창 위치와 알림 색상을 수정할 수 있습니다.
DBM은 공격대 경보 창에 "X : Y" 같은 알림을 표시합니다.]]
L.ColorResetted 			= "현재 색상 설정을 초기화 합니다."
L.ShowWarningsInChat 		= "알림을 대화창에서도 보기"
L.ShowSWarningsInChat 		= "특수 경고를 대화창에서도 보기"
L.ShowFakedRaidWarnings 	= "알림을 공격대 경보처럼 보기"
L.WarningIconLeft 			= "알림 왼쪽에 주문 아이콘 보기"
L.WarningIconRight 			= "알림 오른쪽에 주문 아이콘 보기"
L.WarningIconChat 			= "대화창 알림 메세지에 주문 아이콘 보기"
L.ShowCountdownText			= "초읽기를 진행중일때 화면중앙에 초읽기 글자 표시(기본 숫자로 읽을때만 작동)"
L.RaidWarnMessage 			= "<Deadly Boss Mods>를 사용해 주셔셔 감사합니다."
L.BarWhileMove 				= "알림 위치 수정"
L.RaidWarnSound				= "알림 소리"
L.CountdownVoice			= "기본 숫자 읽기 소리 설정"
L.CountdownVoice2			= "보조 숫자 읽기 소리 설정"
L.SpecialWarnSound			= "특수 경고 소리 1(SW1)"
L.SpecialWarnSound2			= "특수 경고 소리 2(SW2)"
L.SpecialWarnSound3			= "특수 경고 소리 3(SW3)"

-- Tab: Generalwarnings
L.Tab_GeneralMessages 		= "대화창 설정"
L.CoreMessages				= "일반 메세지 설정"
L.ShowLoadMessage 			= "대화창에 경보 불러오기 메세지 보이기"
L.ShowPizzaMessage 			= "다른 사용자가 DBM 바를 보낸 경우 메세지 보이기"
L.ShowCombatLogMessage 		= "DBM이 전투 기록을 시작/중지할 경우 메세지 보이기"
L.ShowTranscriptorMessage	= "DBM이 Transcriptor 기록을 시작/중지할 경우 메세지 보이기"
L.CombatMessages			= "전투 메세지 설정"
L.ShowEngageMessage 		= "대화창에 우두머리 전투 시작 메세지 보이기"
L.ShowKillMessage 			= "대화창에 우두머리 처치 메세지 보이기"
L.ShowWipeMessage 			= "대화창에 우두머리 전멸 메세지 보이기"
L.ShowRecoveryMessage 		= "대화창에 바 복구 메세지 보이기"
L.WhisperMessages			= "귓속말 설정"
L.AutoRespond 				= "우두머리 전투 중 귓속말을 받은 경우 자동 응답 메세지 보내기"
L.EnableStatus 				= "'status' 라는 귓속말을 받은 경우 자동 응답 메세지 보내기"
L.WhisperStats 				= "귓속말 자동 응답시 처치/전멸 횟수 포함하기"

-- Tab: Barsetup
L.BarSetup  				= "바 설정"
L.BarTexture 				= "바 무늬"
L.BarStyle 					= "바 작동 방식"
L.BarDBM					= "DBM"
L.BarBigWigs				= "BigWigs(애니메이션 없음)"
L.BarStartColor	 			= "시작 색상"
L.BarEndColor 				= "마지막 색상"
L.Bar_Font					= "바 글꼴"
L.Bar_FontSize				= "글꼴 크기: %d"
L.Bar_Height				= "바 높이: %d"
L.Slider_BarOffSetX 		= "새로운 바의 수직 기준점: %d"
L.Slider_BarOffSetY 		= "바 간격: %d"
L.Slider_BarWidth 			= "바 너비: %d"
L.Slider_BarScale 			= "바 크기: %0.2f"
L.AreaTitle_BarSetup 		= "바 설정"
L.AreaTitle_BarSetupSmall 	= "기본 바 설정"
L.AreaTitle_BarSetupHuge 	= "커다란 바 설정"
L.EnableHugeBar 			= "커다란 바 사용"
L.BarIconLeft 				= "왼쪽 아이콘"
L.BarIconRight 				= "오른쪽 아이콘"
L.ExpandUpwards				= "바를 위로 쌓기"
L.FillUpBars				= "바를 채워나가기"
L.ClickThrough				= "바 클릭시 바 정보 표시 안함"
L.Bar_DBMOnly				= "아래 설정은 바 작동 방식이 \"DBM\"으로 되어 있을 때만 작동합니다."
L.Bar_EnlargeTime			= "남은시간 %d초 미만 바 확대"
L.Bar_EnlargePercent		= "남은시간 비율 %0.1f%% 미만 바 확대"
L.BarSpark					= "바 끝 강조"
L.BarFlash					= "만료되기 직전의 바를 깜빡이기"

-- Tab: Spec Warn Frame
L.Panel_SpecWarnFrame		= "특수 경고 설정"
L.Area_SpecWarn				= "특수 경고 설정"
L.SpecWarn_Enabled			= "특수 경고 사용"
L.SpecWarn_FlashFrame		= "특수 경고 화면 반짝임 효과 사용"
L.SpecWarn_AdSound			= "특수 경고 고급 소리 설정 기능 활성화(UI 재시작 필요)"
L.SpecWarn_Font				= "특수 경고에 사용되는 글꼴"
L.SpecWarn_FontSize			= "글꼴 크기: %d"
L.SpecWarn_FontColor		= "글꼴 색상"
L.SpecWarn_FontType			= "글꼴 선택"
L.SpecWarn_FlashColor		= "반짝임 색상"
L.SpecWarn_FlashDur			= "반짝임 지속시간: %0.1f"
L.SpecWarn_FlashAlpha		= "반짝임 투명도: %0.1f"
L.Area_SpecWarnFont			= "특수 경고 글꼴 설정"
L.SpecWarn_DemoButton		= "예제 보기"
L.SpecWarn_MoveMe			= "위치 설정"
L.SpecWarn_ResetMe			= "초기화"

-- Tab: HealthFrame
L.Panel_HPFrame				= "우두머리 체력 바 설정"
L.Area_HPFrame				= "우두머리 체력 바 설정"
L.HP_Enabled				= "우두머리별 설정을 무시하고 항상 우두머리 체력 바 보기"
L.HP_GrowUpwards			= "우두머리 체력 바를 위로 쌓기"
L.HP_ShowDemo				= "체력 바 보기"
L.BarWidth					= "바 길이: %d"

-- Tab: Spam Filter
L.Panel_SpamFilter				= "기타 설정"
L.Area_SpamFilter				= "일반 기능 끄기 설정"
L.StripServerName				= "알림 및 바에서 서버명 보이지 않기"
L.SpamBlockBossWhispers			= "전투 중 다른 공격대원 또는 파티원이 보낸 &lt;DBM&gt; 귓속말 감추기"
L.BlockVersionUpdateNotice		= "업데이트 알림 창 끄기(추천하지 않음)"
L.ShowBigBrotherOnCombatStart	= "전투 시작시 BigBrother 버프 체크 실행하기"
L.BigBrotherAnnounceToRaid		= "BigBrother 버프 체크 결과를 공격대에 알리기"

L.Area_SpamFilter_Outgoing		= "경고 기능 끄기 설정(다른 설정보다 항상 우선됨)"
L.SpamBlockNoShowAnnounce		= "알림 보이지 않기"
L.SpamBlockNoSendWhisper		= "다른 공격대원 또는 파티원에게 귓속말 알림을 보내지 않기"
L.SpamBlockNoSetIcon			= "전술 목표 아이콘 설정하지 않기"
L.SpamBlockNoRangeFrame			= "거리 창 보이지 않기"
L.SpamBlockNoInfoFrame			= "정보 창 보이지 않기"
L.SpamBlockNoHealthFrame		= "우두머리 체력 바 보이지 않기"

L.Area_PullTimer				= "전투 예정 및 시작 기능 설정"
L.DontShowPTNoID				= "다른 인스턴스에 있는 사용자가 보낸 전투 예정 신호 차단"
L.DontShowPT					= "전투 예정 및 시작 바 숨기기"
L.DontShowPTText				= "전투 예정 알림 숨기기"
L.DontPlayPTCountdown			= "전투 예정 및 시작 초읽기 소리 끄기"
L.DontShowPTCountdownText		= "전투 예정 및 시작 초읽기 글자 숨기기"
L.PT_Threshold					= "전투 예정 및 시작 소리/글자를 몇 초부터 보여줄 것인지 설정: %d"

L.Panel_HideBlizzard			= "블리자드 기능 끄기 설정"
L.Area_HideBlizzard				= "블리자드 기능 끄기 설정"
L.HideBossEmoteFrame			= "전투 중 블리자드 기본 레이드 경보 끄기"
L.HideWatchFrame				= "전투 중 퀘스트 추척 창 숨기기"
L.HideTooltips					= "전투 중 게임 툴팁 끄기"
L.SpamBlockSayYell				= "전투 중 대화 말풍선 숨기기"
L.DisableCinematics				= "게임 내 동영상 끄기"
L.AfterFirst					= "1회 이상 본 동영상"
L.Always						= "모든 동영상"

-- Misc
L.FontHeight = 16
